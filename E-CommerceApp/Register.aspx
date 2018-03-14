<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frm_register.aspx.cs" Inherits="E_CommerceApp.frm_register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="UserInfoDatabase" DefaultMode="Insert" CssClass="container">
            <InsertItemTemplate>
                <asp:Label ID="lbl_personalHeader" runat="server" Text="Personal Information" CssClass="h3"></asp:Label>
                <hr />
                <div class="form-row">
                    <div class="form-group col-sm-4">
                        <asp:TextBox ID="first_nameTextBox" runat="server" Text='<%# Bind("first_name") %>' CssClass="form-control input-lg"
                            Placeholder="First Name" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required." ControlToValidate="first_nameTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="This field may only contain letters and spaces." ControlToValidate="first_nameTextBox" ForeColor="#FF5050" ValidationExpression="^[a-z A-Z]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group col-sm-4">
                        <asp:TextBox ID="middle_nameTextBox" runat="server" Text='<%# Bind("middle_name") %>' CssClass="form-control"
                            Placeholder="Middle Name" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="This field is required." ControlToValidate="middle_nameTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="This field may only contain letters and spaces." ControlToValidate="middle_nameTextBox" ForeColor="#FF5050" ValidationExpression="^[a-z A-Z]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group col-sm-4">
                        <asp:TextBox ID="last_nameTextBox" runat="server" Text='<%# Bind("last_name") %>' CssClass="form-control"
                            Placeholder="Last Name" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="This field is required." ControlToValidate="last_nameTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="This field may only contain letters and spaces." ControlToValidate="last_nameTextBox" ForeColor="#FF5050" ValidationExpression="^[a-z A-Z]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group col-sm-12">
                        <asp:TextBox ID="contact_numberTextBox" runat="server" Text='<%# Bind("contact_number") %>' CssClass="form-control"
                            Placeholder="Contact Number" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="This field is required." ControlToValidate="contact_numberTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="This field may only contain numbers." ControlToValidate="contact_numberTextBox" ForeColor="#FF5050" ValidationExpression="^[\d]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                </div>


                <asp:Label ID="lbl_AccountDet" runat="server" Text="Account Information" CssClass="h3"></asp:Label>
                <hr />
                <div class="container">
                    <div class="form-group">
                        <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' CssClass="form-control"
                            Placeholder="E-mail Address" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="This field is required." ControlToValidate="emailTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Invalid e-mail address." ControlToValidate="emailTextBox" ForeColor="#FF5050" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>

                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>' CssClass="form-control"
                            Placeholder="Password" TextMode="Password" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="This field is required." ControlToValidate="passwordTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>

                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="confirmPasswordTextBox" runat="server" CssClass="form-control"
                            Placeholder="Confirm Password" TextMode="Password" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="This field is required." ControlToValidate="confirmPasswordTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="passwordTextBox" ControlToValidate="confirmPasswordTextBox" Display="Dynamic" ErrorMessage="The passwords you entered do not match." ForeColor="#FF5050"></asp:CompareValidator>

                    </div>
                </div>


                <br />


                <asp:Label ID="lbl_billingHeader" runat="server" Text="Billing Information" CssClass="h3"></asp:Label>
                <hr />
                <div class="container">
                    <div class="form-group">
                        <asp:TextBox ID="addressTextBox" runat="server" Text='<%# Bind("address") %>' CssClass="form-control"
                            Placeholder="Address" TextMode="MultiLine" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="This field is required." ControlToValidate="addressTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>

                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="postal_codeTextBox" runat="server" Text='<%# Bind("postal_code") %>' CssClass="form-control"
                            Placeholder="Postal Code or Zip Code" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="This field is required." ControlToValidate="postal_codeTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="Invalid postal code or zip code." ControlToValidate="postal_codeTextBox" ForeColor="#FF5050" ValidationExpression="^([0-9]{4})$" Display="Dynamic"></asp:RegularExpressionValidator>


                    </div>
                </div>

                <br />

                <asp:Label ID="lbl_crdtInfo" runat="server" Text="Credit Card Information" CssClass="h3"></asp:Label>
                <hr />
                <div class="container">

                    <div class="form-group">
                        <asp:TextBox ID="card_ownerTextBox" runat="server" Text='<%# Bind("card_owner") %>' CssClass="form-control"
                            Placeholder="Credit card owner's name as seen on the card" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="This field is required." ControlToValidate="card_ownerTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ErrorMessage="This field may only contain letters and spaces." ControlToValidate="card_ownerTextBox" ForeColor="#FF5050" ValidationExpression="^[a-z A-Z]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="form-row">
                        <div class="form-group col-sm-4">
                            <asp:TextBox ID="card_numberTextBox" runat="server" Text='<%# Bind("card_number") %>' CssClass="form-control"
                                Placeholder="Credit Card Number" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="This field is required." ControlToValidate="card_numberTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ErrorMessage="Invalid credit card number." ControlToValidate="card_numberTextBox" ForeColor="#FF5050" ValidationExpression="^[\d]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div class="form-group col-sm-4">
                            <asp:TextBox ID="card_expiryTextBox" runat="server" Text='<%# Bind("card_expiry") %>' CssClass="form-control" TextMode="Date"
                                Placeholder="Card Expiration Date" />
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="card_expiryTextBox" Display="Dynamic" ErrorMessage="Please enter a valid date." ForeColor="#FF5050" Type="Date" Operator="DataTypeCheck"></asp:CompareValidator>


                        </div>
                        <div class="form-group col-sm-4">
                            <asp:TextBox ID="card_secNumberTextBox" runat="server" Text='<%# Bind("card_secNumber") %>' CssClass="form-control"
                                Placeholder="Security Number" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="This field is required." ControlToValidate="card_secNumberTextBox" Display="Dynamic" ForeColor="#FF5050"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ErrorMessage="Invalid security code." ControlToValidate="card_secNumberTextBox" ForeColor="#FF5050" ValidationExpression="^([0-9]{3,4})$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>

                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Submit" CssClass="btn btn-outline-success" />
                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Reset Fields" CssClass="btn btn-outline-danger" />
            </InsertItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="UserInfoDatabase" runat="server" ConnectionString="<%$ ConnectionStrings:UserConnectionString %>" DeleteCommand="DELETE FROM [userInfo] WHERE [Id] = @Id" InsertCommand="INSERT INTO [userInfo] ([first_name], [middle_name], [last_name], [email], [password], [contact_number], [address], [postal_code], [card_owner], [card_number], [card_expiry], [card_secNumber], [latest_cart_id]) VALUES (@first_name, @middle_name, @last_name, @email, @password, @contact_number, @address, @postal_code, @card_owner, @card_number, @card_expiry, @card_secNumber, @latest_cart_id)" SelectCommand="SELECT * FROM [userInfo]" UpdateCommand="UPDATE [userInfo] SET [first_name] = @first_name, [middle_name] = @middle_name, [last_name] = @last_name, [email] = @email, [password] = @password, [contact_number] = @contact_number, [address] = @address, [postal_code] = @postal_code, [card_owner] = @card_owner, [card_number] = @card_number, [card_expiry] = @card_expiry, [card_secNumber] = @card_secNumber, [latest_cart_id] = @latest_cart_id WHERE [Id] = @Id" OnInserting="UserInfoDatabase_Inserting">
            <InsertParameters>
                <asp:Parameter Name="first_name" Type="String" />
                <asp:Parameter Name="middle_name" Type="String" />
                <asp:Parameter Name="last_name" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="password" Type="String" />
                <asp:Parameter Name="contact_number" Type="Decimal" />
                <asp:Parameter Name="address" Type="String" />
                <asp:Parameter Name="postal_code" Type="Decimal" />
                <asp:Parameter Name="card_owner" Type="String" />
                <asp:Parameter Name="card_number" Type="Decimal" />
                <asp:Parameter DbType="Date" Name="card_expiry" />
                <asp:Parameter Name="card_secNumber" Type="Decimal" />
                <asp:Parameter Name="latest_cart_id" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
    </div>

</asp:Content>
